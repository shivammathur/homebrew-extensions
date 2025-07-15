# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT82 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.19.1.tar.gz"
  sha256 "bfaf2ba7bdb11663bd9364096daa246fa4bfb1dec1eed9fa53ed9a8d5ed1f647"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "abb29f75eb01b462807da39f34a6ac6e229186f03ecb856c4a489ec908a947bc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "33f90a350e69b4c6d23d2f6d835c285bf90d002cc6c5bd36a3bdb68907fcc3a2"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "25cac7dae2037894a053676269350068048277d68ae85eeb306de78f0153d39a"
    sha256 cellar: :any_skip_relocation, ventura:       "76f27bc88430652a9039bbe40f71386016007896c2afe4b6576579d37f1f005b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "892b53870d6cb792fae36d36f76ee69e59cb6238ea2c2c662bcdfb6ad2aef169"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dee4931b81f353ca316c67140f4ec0a986e55fd6fa37d9e84140214c152ea2a9"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-vld"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
