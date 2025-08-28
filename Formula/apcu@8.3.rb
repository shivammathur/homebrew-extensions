# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT83 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.27.tgz"
  sha256 "1a2c37fcad2ae2a1aea779cd6ca9353d8b38d4e27dde2327c52ff3892dfadb3f"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0e82fbc9610083dd16ae216bc00b65b70a3a86ecf70ac546fc6478ef7baa05be"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1d5fcdf5721e20a7aa7277fb9485e21c7ef0cf0e659b13b350e5797e43deebf4"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0ce5e616511f4b0a2c8e3cf4696c42337eb86e3284a2431ceceb665036624c0d"
    sha256 cellar: :any_skip_relocation, ventura:       "6b81848e48f14c0348a2bf2bd1b6aa486eace5f1487e592fe20b11ec8b7c6783"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c5825b2a2a5edb067ecdaf612720fdbf1785cfe2fb5de54eb0f9d222956451b9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bd1b8b1af096c476f167b6e159d79bce8195045ed7cf40f5b2c61460ad6ba2db"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
