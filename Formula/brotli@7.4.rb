# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT74 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "1777d4db97b3e880d2fa3378ba7d1f74191d43e6bd3ded6c3ed54205db88215f"
    sha256 cellar: :any, arm64_sequoia: "be0c73611925da86224c60e8ba4dbcb86c2c708ce7b2ef149186126031d244de"
    sha256 cellar: :any, arm64_sonoma:  "2ced60ce41fc38516f280b36e505b93b3c46afd0df9cdcc1febdc45d589c74be"
    sha256 cellar: :any, sonoma:        "8679fffb28318c7c1bcee7a028ef393a20c62e342d93bcfe99256ac7a368e8cb"
    sha256 cellar: :any, arm64_linux:   "d00404f876a9b2d6de18c896f2de6362bf5b7953ab9b070797039c1b6297395e"
    sha256 cellar: :any, x86_64_linux:  "bc722c9e5b27befabe1a653fc0d7bf9a5eef67d463e2380750cee29f4bc086f0"
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
