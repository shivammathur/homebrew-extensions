# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT82 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.5.tgz"
  sha256 "4b8c8aacf48737c0d741a2401f4c495318ca18879e9bfcef5f698946ef28c671"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4c56c4f484395e32517aca2f41ca3c48178cbbc2364572264357cd78f728752b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b81ce4aea114535f62153fa51ac7c4c0f657ac6c416c3a678f876a8e5c87947a"
    sha256 cellar: :any_skip_relocation, ventura:        "472a15813d554fc4fae4428e7c89c269296a496822edf78fbf52c23ae4eeea77"
    sha256 cellar: :any_skip_relocation, monterey:       "7add19327e2c693294dcfd1d04cfa8e422b53eedb30b4828820084f3f830804a"
    sha256 cellar: :any_skip_relocation, big_sur:        "9a8f7b30b7d4d62428afdbda72bcf1942ed3a6c3c3f57153807f4283b918907a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d811eef5bbe4de1ae8543693dd714580a9d64b32ceecd6981fc73d5b094b256c"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
