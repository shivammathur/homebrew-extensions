# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT72 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "10a747baac9c8642a389e897c513fd1aacb65a9f737eb2771a8cc6aa8d13d955"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "0ffe708dafb7fd8a1a3cbbb0abf5ea16e937c52a11e865726a2e61dc79d532e0"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e58b4f15ccf20f4c1d8fc12d149592c43aa6c78e77f2c6dc92d119a72690afdb"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "72814049658f58aa7a781b19923b0f70eaa5817eb36142cc6656995948da76d6"
    sha256 cellar: :any_skip_relocation, ventura:        "984547e25a4c5fc410d4bfc992ddb2701aa8f7506c104c028ec34c55b030efa2"
    sha256 cellar: :any_skip_relocation, monterey:       "036c22a0cf8157f7b4571058cbb304338a527257def017bd5cd044c4c1cc8735"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "286b0e2e885ca3ac87abdad5cbc4addc5102e34258ff56fcda959d30ed13d70a"
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
