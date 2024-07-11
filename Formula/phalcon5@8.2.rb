# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.8.0.tgz"
  sha256 "d80b137763b790854c36555600a23b1aa054747efd0f29d8e1a0f0c5fa77f476"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "c9a36f44f98b5f5a07a8d560598f2e816bda42b02146b836e3a5b7085662aed9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4f29a881adbb66a3bce65bf13d4eaa54427fe3886ce8ccbf9708bb3c8eaf20e9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "311b99afdfa66a8acb6e0872020917e08af9e54a33162beb04386ded9afd40bf"
    sha256 cellar: :any_skip_relocation, ventura:        "70491885a4744c7e5435d8e20ec573b8620b66d873e2adffc08277f30bdb506b"
    sha256 cellar: :any_skip_relocation, monterey:       "b4d77395fa2969b341a65c55b7076f9734e469e91732449701bff77c24fa8580"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "33ef7f6037c5f819b2e28804ce954514296d6821ce0f572e7fc8f8afd034c780"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
