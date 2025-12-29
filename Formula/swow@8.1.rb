# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT81 < AbstractPhpExtension
  init
  desc "Concurrent coroutine network communication engine"
  homepage "https://github.com/swow/swow"
  url "https://github.com/swow/swow/archive/refs/tags/v1.6.2.tar.gz"
  sha256 "4939bb0390ad95861e7f98c279df41a7a00ca21fc94383be812a5163d63598e7"
  head "https://github.com/swow/swow.git", branch: "develop"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "fce7a6d2090cdc8d712b231b01fa86bb937938ceeeb04e26232cc4d15efd81d0"
    sha256                               arm64_sequoia: "901b15f79e52db66d76e2290f41cb802dd35cfc01a54559a1160dae6e8467f3c"
    sha256                               arm64_sonoma:  "bfc532dcdd9e7ce1226a56e645841e796ed90ffd04ff52291f13b057d177ebbc"
    sha256 cellar: :any,                 sonoma:        "d287aef0de8ca654852a7307da8b0728cab0629ec1f09f9801683a352b51c4ef"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "81cc9842ba192098a33fa58e0ec24dac2e94e2ae165a0bd0f3a7a1b3e6ca9f95"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bf5845740c876b768c7554fa2b8d416b5a48606176f5e3b50b9681fb8fbc509e"
  end

  depends_on "openssl@3"
  depends_on "libpq"

  conflicts_with "swoole@8.1", because: "both provide swoole-like coroutine functionality"

  def install
    args = %w[
      --enable-swow
      --enable-swow-ssl
      --enable-swow-curl
      --enable-swow-pdo-pgsql
    ]
    Dir.chdir "ext"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
