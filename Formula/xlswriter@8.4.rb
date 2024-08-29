# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT84 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.6.tgz"
  sha256 "b05b58803ea4a45f51f8344e8b99b15aff6adb76e8ab4c0653b6bf188d3b315f"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "4ac93e8a0402186eb0c5827153a919a7526bb9819b094eaa2fe317220b352bf7"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c314253dbecc0205bbe20f3dfbec504054f9821ad461723dfea4a9b75ed1bba2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ea6af74eb907e713350df43d644d8784cc544c1d308f8ff42630e3f05ca130b4"
    sha256 cellar: :any_skip_relocation, ventura:        "699daec15b7b1ba1036b2a582ab988e977ba4d04ff1df21493d2b2a247c7b346"
    sha256 cellar: :any_skip_relocation, monterey:       "987510a911b24375d6cb9c288949715486de3d6990e1ee4786f08db65cf08274"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3eaa5730aadb9e130cd771844d0849c01ae58eda6ebd3a2167bc0b838b59c803"
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
