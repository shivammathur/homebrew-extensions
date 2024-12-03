# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT73 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "ab3ae5643272754a0dfe511f7ab387d1806532f629f32ad88fd2122aa16d67cd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7f8ebd05c7b90d07f5079c1cfe750ee1d41ec064098c873089ad1fe79c57c7e4"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4f2de89f852372b524c747ab77d1295ce21d23f2b421fac3cb9c1f1b9b92a284"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c3ad9e9ad801ad88734cfc62f1ba258a6cb0726ba9792123c1ffc2253d1b1c82"
    sha256 cellar: :any_skip_relocation, ventura:        "17c89f9249594a0fb6750fb5981848ced72fab6f6333c27760891476487c8823"
    sha256 cellar: :any_skip_relocation, monterey:       "3e1af74be6956aa68c090d08b7a0c81db8148887c0bf677816847c29e6472ec0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9e09281795549560f94a5e0e23a12754c48b6babb81eba5ab76dd01422455d66"
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
