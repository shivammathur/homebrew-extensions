# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT72 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.5.tgz"
  sha256 "4b8c8aacf48737c0d741a2401f4c495318ca18879e9bfcef5f698946ef28c671"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5e83a4208cc8b8eb7fcba558303807942da5268941c020c798d88a02ef162f43"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6061a9d8f4f8f63fc7f6103f363dc8c1f629bd3dab965c59f7fb704d55a158e8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9c4e764939dcddf61e66f78ac618068ce3bf7fa9bf902e68394d36b368182fb6"
    sha256 cellar: :any_skip_relocation, ventura:        "d580999a6876711cff16175277513710f1c92874e9eb22ec8938e316b0f7f6d8"
    sha256 cellar: :any_skip_relocation, monterey:       "d4c68cc194ae354b38dfc43d9f15f59d675c1169a78ab7d56b298426d3b28c40"
    sha256 cellar: :any_skip_relocation, big_sur:        "bf17ad75571ad6d94a7e7d0180ecfd3ac8ad33c03ec813d867759dc0c5f78a2b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c53c31c7a4add8fbf1196eaa1bbf6dea11aef9e9424bfcd71089f271dd0ef335"
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
