# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "10db7dfe7728a3b81f2db92191f47e5bad13fefea4f908a5c1819ee92094d8dc"
    sha256 cellar: :any, arm64_sequoia: "165eb10ec62f9fbe49615875f9b7306073dfe5bf80f40159a54311edce6ada19"
    sha256 cellar: :any, arm64_sonoma:  "c0bad0aff0229babc0f1f4f9629e604e6b90cf031f3a8bb3372da0d87a9e23ba"
    sha256 cellar: :any, sonoma:        "abd0b277b201efee7047fa162e7c2d58257575e9157278180f77794eec75805e"
    sha256 cellar: :any, arm64_linux:   "05ab63d4fe86af6c7b8952318d396277a74639ace744ca32cdcabcea03545e94"
    sha256 cellar: :any, x86_64_linux:  "671451ddf1b14f73a92cc757d52e5861ccc528b77ed5f54872f7519c363b4899"
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
