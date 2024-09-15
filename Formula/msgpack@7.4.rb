# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT74 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0.tgz"
  sha256 "82aa1e404c5ff54ec41d2a201305cd6594ed14a7529e9119fa7ca457e4bbd12a"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "61b74827058190ad527979afff9f995c44de518a636e59343f00b0b951434fa7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "344c0c3ade4c110b8ffbe1072ba0defc2fdba4cb597cc3bd0fec8b65d8630026"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "74062a8898b7d4c7811d05782c5860b406df5470ba47735ea0f545e1f7aa34dd"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b72e1a45f1f3af1996491a65fcbfed3f87ca3c648ac8ecb22c9ccbd873fc930a"
    sha256 cellar: :any_skip_relocation, ventura:        "68c7de6393c7becf6e6b33c5e21b95d64895b865f2454aadd3081e92899bb249"
    sha256 cellar: :any_skip_relocation, monterey:       "c23f6cc03d7e13ae930068508f4132806acc6a6662acbf474ffee267ca7ac92f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f4f91901cbe7fb6b8e93f4210f6460ad21393cb6ce35138d8a0ad423cd6a0791"
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
