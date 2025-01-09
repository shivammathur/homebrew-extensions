# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT74 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "0c3907ab7cf7b37232d0daeba38eabbb9cf66d4e4416c036a3fecb76f19f4d82"
    sha256 cellar: :any,                 arm64_sonoma:   "0e2d39f257d7d6c164e2cc6a675cf23aa9b6e6549829b95e29d57a6e45dd4f9d"
    sha256 cellar: :any,                 arm64_ventura:  "3ee905442fddf7d8759a4bda6026a6d1dadeadd7ac1fb56261ed982ad9941ecb"
    sha256 cellar: :any,                 arm64_monterey: "ebd477a307144d9356ce42bbb8d209b9c24917901b7d94818493eacedf935ca3"
    sha256 cellar: :any,                 ventura:        "a23272a336d35c9f46736e9be78d0c2785846b84e80f800bcebc56f2f9ff90a9"
    sha256 cellar: :any,                 monterey:       "ff75a963bac7183449faae2b34d2f8c5252dceeb4c5f58afcd0e19d704343a0f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d5677eab63cb80463efc828d0326fca7ada760292a61867e1d6972804ae5e710"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
