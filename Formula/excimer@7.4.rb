# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT74 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.5.tgz"
  sha256 "cf49acd81a918ea80af7be4c8085746b4b17ffe30df3421edd191f0919a46d1d"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6e34031f95e79972fcb5ba201187a322556fee47b4ee5ff46ac8e7d54fffa782"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ae6f35634520fc8a4ac9b28c0cd2598fe9bc7731bd383544e544bdc43f2a6933"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ac5088102485a1d9163f7489026358a75a91938613951735064f4336be2edc5b"
    sha256 cellar: :any_skip_relocation, sonoma:        "4ba44393ca35a1e6eae73069809fb7b030156fd8036c0695ff496f67ac3a9ad3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "47efc7d47a73016db22a45d1a5f9cd738b42aabb600e04d5585ecf224f2f5c0e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "47ed75f93df59010352ac500e6f6e74f7378f5a842f1437556a753617f7f75a5"
  end

  def install
    Dir.chdir "excimer-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-excimer"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
