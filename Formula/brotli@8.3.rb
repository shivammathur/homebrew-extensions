# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "63589af70808fad72ff84df7781e9398398d749b3e84e17f07c6e66d8c2f3e34"
    sha256 cellar: :any, arm64_sequoia: "b815ff30e5b40acda5d35eb29be1ece083805e42f42cf70dbb010b9e3af35043"
    sha256 cellar: :any, arm64_sonoma:  "9e00c58d82eb96bd68a6d0f6d05418b47db50c77fc696abfc9e08093d3486e42"
    sha256 cellar: :any, sonoma:        "f043ce033c3702091d381a9c2c1273d8d5fca5b4657f5f487c9ce5523c1db6d8"
    sha256 cellar: :any, arm64_linux:   "4d2c5901997586dc2bec0959df3f8606b4aaf134311dbd78c455fbcb8251b7d7"
    sha256 cellar: :any, x86_64_linux:  "6ffdc82665fcf2582c47eed410cfe7a329c51a17cee47f4973bd09cb3d0b003c"
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
