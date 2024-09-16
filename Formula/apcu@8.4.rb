# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT84 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.23.tgz"
  sha256 "67ee7464ccad2335c3fa4aeb0b8edbcf6d8344feea7922620c6a13015d604482"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "21615f1489d6dcf211305e67135d885e2431209902c03bfee691fb95524087f9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "70f41f06c03fb92209cde364f4d1c8c587e0f83f0e005f6e25fe4406e1038d79"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c2bf5960cf1b498cd2e86e7ee9bf9a1f69914ac5bf5b4ee70ce4adf4faedc88d"
    sha256 cellar: :any_skip_relocation, ventura:        "bf183e95123ceab91770c393a980d3d80f392d934db755f07a0150bea637438a"
    sha256 cellar: :any_skip_relocation, monterey:       "dc391f26ecceb4c281e4bf333a68023491d687261d43704e84fe88784a5208b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b21f6dd147b93a3f3a10974d7f6a4833157b89e502e0d88c11ae64d4bd71f27e"
  end

  def install
    Dir.chdir "apcu-#{version}"
    inreplace "config.m4",
      "PHP_NEW_EXTENSION(apcu, $apc_sources, $ext_shared,, \\\\$(APCU_CFLAGS))",
      "PHP_NEW_EXTENSION([apcu], [$apc_sources], [$ext_shared],, [$APCU_CFLAGS])"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
