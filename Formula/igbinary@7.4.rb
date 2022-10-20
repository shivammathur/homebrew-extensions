# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT74 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.9.tar.gz"
  sha256 "45b7e42b379955735c7f9aa2d703181d0036195bc0ce4eb7f27937162792d177"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "59735f5779040d3657a1bcb9be787ba71bfb9f8aac121c64a880cfa10b3c7aaa"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "38613f5e902a47e7bf3088b1dfe95401a5d26ce68b150076ac774fcd6a2d47ac"
    sha256 cellar: :any_skip_relocation, monterey:       "c164477127ff024fb3890173ea5818972d6290b1ad67080d11b2edc802ee9b4c"
    sha256 cellar: :any_skip_relocation, big_sur:        "62880e3a2c7cdae3fc15dffcc367105c8e062541cd2c1586385714f77fad2628"
    sha256 cellar: :any_skip_relocation, catalina:       "5d5429ab43f8f93eb3ad3780316853fb96b51ead5b352aa2abc0c266c1249c8d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fb7c380a65584bb280e2c9e9819a2c23838f3835f616ff2b1c661f266a9ec390"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
