# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT70 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.1.2.tgz"
  sha256 "912ff4d33f323ea7cb04569df5ae23c09ce614412a65c39c2ca11f52802abe82"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/msgpack@7.0-2.1.2"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8942e15b2f19eccfc5c703faeac33ac4c25187d6868a39cb8ba7079aec253e8c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "12bb646cefa7b38bdc5e6a3205a60a9b533165abfbc143cf6405344479abdcac"
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
