# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT83 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0RC1.tgz"
  sha256 "55ad876ba2340233450fc246978229772078f16d83edbab0f6ccb2cc4b7ca63f"
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "02a392d1cb42e74bde2599be261d867306eda2d148a284e7c85efea429b7b564"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "0fd04b0e9867da5103e5941ddb4266b17869b7561252612d0f6b4d731f8caa33"
    sha256 cellar: :any_skip_relocation, monterey:       "f54efb90c2a9c71286816668fd7822467897b09597496017af1c15f199609b26"
    sha256 cellar: :any_skip_relocation, big_sur:        "f95dc49f57f1f26beb524a33c3a40d403d7eb52b4eee03a521ce35bebff0747a"
    sha256 cellar: :any_skip_relocation, catalina:       "7dcf5efe87ca71dd823bbbe06fa51a5f623a4dacdde24bd1d7b4dd02e22f7034"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f5830f0fd50acae4955276494c2d74584b21d6e3ca676aea9f938ed4245f3ddf"
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
