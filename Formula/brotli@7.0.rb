# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT70 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.21.0.tgz"
  sha256 "97a69edd4f71046b1bd285d914741a60478e69a1db785c2b42aed940ab1fa18f"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "b5df3b048dab59ed2c7bd6017011c0a07e5c2ae38152e0dfb3332ef14e50be23"
    sha256 cellar: :any, arm64_sequoia: "ba931a15b23727a1fefbf9ca5100d8f61ba1523225ef835f9bef405c56233fa3"
    sha256 cellar: :any, arm64_sonoma:  "dec1727623bdee35ee5a0d6d21a5531edab7bcfd582b32805e098c3535949410"
    sha256 cellar: :any, sonoma:        "44927f3d14da98f2c2f7b4419a5915ca45f215a200080be6f27f5e9f3e53cc5c"
    sha256 cellar: :any, arm64_linux:   "bad65a1e4d4128f09ff745e5bb02fa377537022fc1775218b5991ae8e9be3486"
    sha256 cellar: :any, x86_64_linux:  "7bc51af5f245fb2801353a01cf6575220ff6c5cf4a22aef39698d906e0100a8f"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Utils::Path.formula_opt_prefix("brotli")}
    ]
    Dir.chdir "brotli-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
