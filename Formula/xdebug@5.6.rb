# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT56 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://pecl.php.net/get/xdebug-2.5.5.tgz"
  sha256 "72108bf2bc514ee7198e10466a0fedcac3df9bbc5bd26ce2ec2dafab990bf1a4"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "6c4f07c63798af7a08b11f4749b129cc8909af2e2949ee867a280710d73847a2"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "edc7d841bf561cddcbd861d519845b6c7fd655054b4f8e4bbc4c373d793b89a2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9af4b364d4bfc44502cacc96e832b15416590077d0db510feafcd10b0eee05bb"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "41becc4471bec61058f9684636e5b7b5eca8e8b7ae7c2aa4d6427c69ac7b8985"
    sha256 cellar: :any_skip_relocation, ventura:        "aa93a72086aca1726d101fb7b95920cc4e9b01b77ebc68988f26a0e055e645f2"
    sha256 cellar: :any_skip_relocation, big_sur:        "cf4e988a3805069c2fc0ff876cbda1ef84ea1474971a3b358122bf7109956b40"
    sha256 cellar: :any_skip_relocation, catalina:       "ddc7ec2f15a6615f8b1c07da9819e06419801d74c5b0a2be0f3b44ec1a08699f"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "ed86e50b14dbaff7527b1e891ffba447ca7297ceb79699ccf4e975c944a2aad8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7737abdf69947420d8d523e32e482e1c6c42a60ff44fd8c324917c30decc0b12"
  end

  def install
    Dir.chdir "xdebug-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
