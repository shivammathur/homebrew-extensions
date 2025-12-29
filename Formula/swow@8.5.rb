# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT85 < AbstractPhpExtension
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
    sha256                               arm64_tahoe:   "05ac54b8cc44dd94ee4f8caba16d8f09df45dcef396343a47a064b3bd0dc9428"
    sha256                               arm64_sequoia: "5a999beb8ea177f71087dbc6cd00dd4b888e4f8103e03013673bdc7374861783"
    sha256                               arm64_sonoma:  "4898b7f4fc4f8044762dea372baefd9695ba2c33961cb1c0aae1b7adb7d22d4f"
    sha256 cellar: :any,                 sonoma:        "d744a723ff796efabcfe2668054305eb47bd2613007bf47b0fa7a0045b79f52d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fbbe8ceb9d7cef21437d4352435299be3fbf4d870ebcc51660cd19d07f7fb8db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9f5d3cccdd7eb3e272faaf45634847ff17fa26fc377b2b6ee69982b3d65dd383"
  end

  depends_on "openssl@3"
  depends_on "libpq"

  conflicts_with "swoole@8.5", because: "both provide swoole-like coroutine functionality"

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
