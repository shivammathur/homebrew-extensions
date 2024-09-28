# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT85 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.23.tgz"
  sha256 "67ee7464ccad2335c3fa4aeb0b8edbcf6d8344feea7922620c6a13015d604482"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "30fdcd5f44ed76e45718e909fbf599689e3d22745af9cd802f8c2d8eebd5b8f8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "31048ee2032840775523b16e93721b428f8c95cc583e2c619d11c4e005b49e6e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7a199bb09aca876cbc793d0a5cd8b805e102eeeddf65d7ee83e8fa774c7df84b"
    sha256 cellar: :any_skip_relocation, ventura:       "e05880acc9e2aca5022b8f3e6084b7515c29d204300d3e61f230043c502c8038"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2ba87033ed704c9bf5b56b3a00a66e8cdd28ec4f2a11f8c3955e16793d90e3db"
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
