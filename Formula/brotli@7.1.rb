# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT71 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.18.3.tgz"
  sha256 "ed3879ec9858dd42edb34db864af5fb07139b256714eb86f8cf12b9a6221841a"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "c927afdf9be97ad0f63277859d4706984cb155d57be4401a84a44f69ffe13b6f"
    sha256 cellar: :any,                 arm64_sequoia: "eb25bfb08cefe576192ecd796ff86bfc4e46debdc15952618ab73b9fb039af3c"
    sha256 cellar: :any,                 arm64_sonoma:  "d2170c654e640f150dd1ce7e994f33e37e9bf385670655e934a8d46b3b0b9322"
    sha256 cellar: :any,                 sonoma:        "addace16f8bf1735c9f6b3cef023af5b8f694a1b7c6af6a9df474c5aca6bbeff"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1708f291af41fd4251e053e656854c075fa8e74c24306f67feef7a8d5854ab67"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ff68c28bbfa71fcd8935e23fc528f483aa897d3b01dc5c88024794d5f2508993"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Formula["brotli"].opt_prefix}
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
