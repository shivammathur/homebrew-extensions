# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT84 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0RC1.tgz"
  sha256 "55ad876ba2340233450fc246978229772078f16d83edbab0f6ccb2cc4b7ca63f"
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "257740c961f275a3f4eea71953c3e6bb613ac05c8c468fadb1be223bd67035fe"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "b5371ba2c88b5e71ed146e7b03f8523aed8089d7ab03901c01fed344a59f2a9a"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "617251be28955cb60e65cd2d9fc2b141a91fe4ad8ab2ec4690079ee189417430"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0ed58dfd4b172f01692cf729d5a200ac2a3265ff0c9ddb78ccff646bb18b1b36"
    sha256 cellar: :any_skip_relocation, ventura:        "220e93af5d9d29dc3268267afa244558d66d55a9eb24885e30c5372bdc9fa1e7"
    sha256 cellar: :any_skip_relocation, monterey:       "997562209bcd35da28e378a7bf8581a95a349aee80493781300e1758d47ff240"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "920723b3c8c946c9cd10233dc99452cbf8e198115e2c37dcf45d85e667e6d297"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
