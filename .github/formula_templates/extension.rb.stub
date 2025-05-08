# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Extension_Title Extension
class Extension_TitleATNODOT < AbstractPhpExtension
  init
  desc "Extension_Title PHP extension"
  homepage "https://github.com/REPO"
  url "URL"
  sha256 "SHA"
  head "https://github.com/REPO.git", branch: "REPO_BRANCH"
  license "LICENSE_NAME"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
  end

  def install
    CHDIR
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-extension"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
