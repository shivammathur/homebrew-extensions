# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b2243e611c100d15373f956f121fd83c3f9323b131c109cf9282d48a9ba3a596"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9998901d439fb7d5ab62f13d62ca29f30bc5f4461db6e6655aec44c7131e1d9a"
    sha256 cellar: :any_skip_relocation, monterey:       "e5cdf33d96ab15f9a35cd855f5c0e523edbe87bcc57adfe96dcf7069f1c62e75"
    sha256 cellar: :any_skip_relocation, big_sur:        "3e4aaf91ef4c20eb535021729c40b9db96ce66633465d585c819a120a70820ea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "31e86d7f93c8845c159392d36048b51fdc4a6f8e277938bc6de1e049df136698"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
