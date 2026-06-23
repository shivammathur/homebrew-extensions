# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT72 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.1.tgz"
  sha256 "e30be355ab79aaea4568692fbd6073fd7c7f50ea8d3cf12edce40fc0c921d868"
  compatibility_version 1
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d2c60cb91b6e64c4ea2ac6210715676f4feb319c56b12ed6f3b6cd6b9c00d858"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9465579ce2176d4b22927a15464db17ed3832aa891bfe38b541848ef8faaa3dd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "25ea97005743f4a314c7e8d765673d8ea61ba9d2834903d43e13c6bef331a5f7"
    sha256 cellar: :any_skip_relocation, sonoma:        "33cdec751beb39608dbef5a89bd5f78b0640021fccc9b61de0a724d336f9a090"
    sha256 cellar: :any,                 arm64_linux:   "238d3876a57ea07f8b8f1b3394335f32db7728c978d6ce3108edb7967aa58f4f"
    sha256 cellar: :any,                 x86_64_linux:  "fd4d0afbfe3f3458a3e66f24e0183ce5e101b03b527c585e8c0f4b885c4f1755"
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
