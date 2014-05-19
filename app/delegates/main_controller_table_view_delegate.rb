module MainControllerTableViewDelegate

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    case tableView
    when followers_table_user
      @reuseIdentifier ||= "CELL_IDENTIFIER"
      cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
      unless cell
        cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
        cell.selectionStyle = UITableViewCellSelectionStyleNone
      end

      follower = @followers[indexPath.row]
      if follower
        cell.textLabel.text = follower.login.to_s
      end
    when following_table_user
      @reuseIdentifierForFollowing ||= "CELL_IDENTIFIER_FOR_FOLLOWING"
      cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifierForFollowing)
      unless cell
        cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
        cell.selectionStyle = UITableViewCellSelectionStyleNone
      end

      githubber = @following[indexPath.row]
      if githubber
        cell.textLabel.text = githubber.login.to_s
      end
    else
      puts 'NO TABLE FOUND'

    end

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    case tableView
    when followers_table_user
      @followers.count || 0
    when following_table_user
      @following.count || 0
    else
      0
    end
  end

  def tableView(tableView, titleForHeaderInSection: section)
    case tableView
    when followers_table_user
      "Followers"
    when following_table_user
      "Following"
    end
  end

end
