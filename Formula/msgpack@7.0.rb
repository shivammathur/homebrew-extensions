# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT70 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0.tgz"
  sha256 "82aa1e404c5ff54ec41d2a201305cd6594ed14a7529e9119fa7ca457e4bbd12a"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8942e15b2f19eccfc5c703faeac33ac4c25187d6868a39cb8ba7079aec253e8c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "12bb646cefa7b38bdc5e6a3205a60a9b533165abfbc143cf6405344479abdcac"
    sha256 cellar: :any_skip_relocation, ventura:        "7567fc8f049e0f873f92ef58c837cd7458bdb90919bc75c5c248222d15baa44b"
    sha256 cellar: :any_skip_relocation, monterey:       "ac9bdb078f494f37adba0f50cb8b77d73b0ff52fbf4d4b365c6c48f07c360575"
    sha256 cellar: :any_skip_relocation, big_sur:        "87dc6efbd7ffc4c53facbdcca9034ea64e730632d27f34842eb47c7cc0a94aab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "39060cc0d55597084fc2a042015c55225dbd1c83ce5f627020c1d67a0e5405c2"
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
