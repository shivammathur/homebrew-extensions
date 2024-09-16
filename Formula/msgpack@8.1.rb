# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT81 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0RC1.tgz"
  sha256 "55ad876ba2340233450fc246978229772078f16d83edbab0f6ccb2cc4b7ca63f"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "37302fffc3b15e3b6f698b956d44cf625e94eccddabaed50f1536a9c144ea22c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "072f86e2f13e6034f5a3adc31dd21e34e681d9cc2cd6a5b96f0f687904dd0a0c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "11b6a57c1e7e9e00af60b403a0e08de870eb8820ea2b86541aed99539d154a1b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8e2bd55d1f609746058e3ae03e1ef76da3f12b2140ba1835e3e19ec56376b7ae"
    sha256 cellar: :any_skip_relocation, ventura:        "76b74a16990b650960071e4bb2e15416726ce5813c0f70c946afb34faf375040"
    sha256 cellar: :any_skip_relocation, monterey:       "1c7ca7099d8193553aa03377838d039a34737d5034ffc17bb1fbab210567c785"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "615e6d427aad1a42a83445bea2a1df91af9d7c6a962d823e765ea343cb81bb9c"
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
