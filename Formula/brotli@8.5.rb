# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "85cd87e07f53e3d8fe3ef2c5d42de33b5200d7a85017bf5b180e62ab367e6e7a"
    sha256 cellar: :any, arm64_sequoia: "9d7bb50ca51880faab20988b52e16d2db5912466e783e3960d00ba170c2f51ea"
    sha256 cellar: :any, arm64_sonoma:  "8d35cfda286a50e283d0ffd97a57eda785a7db3fa402145f569e5a254d462f9c"
    sha256 cellar: :any, sonoma:        "bf4519f53c3c8720572fb2c3947df4417b9b4b18c509d34444e0e01440aa8978"
    sha256 cellar: :any, arm64_linux:   "24178b253a3dd5708b5b7d7659b79deeb874556b18584c04c21e91ecec4acf65"
    sha256 cellar: :any, x86_64_linux:  "6100b6c50d1b2ef4afab0def54527cdcab164e3c1ea9e422bbe159316f81c38c"
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
