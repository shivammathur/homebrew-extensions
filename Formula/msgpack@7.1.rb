# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT71 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0.tgz"
  sha256 "82aa1e404c5ff54ec41d2a201305cd6594ed14a7529e9119fa7ca457e4bbd12a"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "3a98057709b7bf59487eddb6ee506ee3c49a3cf55e085874b35103d9e1089285"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7e93544c70032e4c88896fea7f6c981ab3dcb9503fe35a0f06c5a7036e54a255"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b9d5aa7bb5954b1ec000925a77c3ad5f2547d601193de1715ec57d10112c155e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a530bb762d6976d4733ad7a37dc769245498fa129d4989d67a1dbb1472314398"
    sha256 cellar: :any_skip_relocation, ventura:        "e4d363f163000f59be135fb08db97c2373eeec8fee5de75b235c2e084f3a898e"
    sha256 cellar: :any_skip_relocation, monterey:       "343b46969be9bbebdcb74921906cb3085bd65bf83d5573ff171a0a6a58000514"
    sha256 cellar: :any_skip_relocation, big_sur:        "27af03e098696f0ff769fdb99f7c071e52cec247da4ec167f4e97e71156cc90e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d25ffd48753e8963e7779cdba2bbe4263c0122863a543308ce93caa66b885b65"
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
