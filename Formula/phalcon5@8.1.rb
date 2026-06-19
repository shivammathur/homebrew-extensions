# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.15.0.tgz"
  sha256 "c0dbe13169a1e03d65a7c8f5a8aca9f00b4e13557337e4651e54a16a393d40d5"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "650dbdebf80673407664cfaf7aae0c649abe2013eec9bb2a23c401777066e1e0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c5d7d38e85ea3774951dae01f22eb1f095affe187e8927436ddb2e4f4e74955a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8c0409c32e0009d780b908ce567e86459185d8a8f56a4602de8c6794749c5be4"
    sha256 cellar: :any_skip_relocation, sonoma:        "7bd0c69b23fde5eea24896933c866b3557d2cf802a7e3d7bbb1f94223cce95bd"
    sha256 cellar: :any,                 arm64_linux:   "ef6ee27f26c9930e7f773cea13dec383bde683af381ddb656ea028bf7e5cd97c"
    sha256 cellar: :any,                 x86_64_linux:  "e8d1b5818975ef02b7c14fadab773bf73c570e08d42fcada13a22dbe7e93147c"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
