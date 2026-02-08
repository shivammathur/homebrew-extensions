# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT70 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-5.0.2.tgz"
  sha256 "74bfb68c7f88013be6374862eed41b616e0bd6aa522142ccf3394470d487d5c9"
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "140ed0b7584e43be6e086aa3b53217f300abd9313f24a73ec1f312518767a5d9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f7d4de56df297468656c057f0113a7005713b9b9d5df8f1721ea67e675e3c74b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b08fca3b4c4944bc24879bab343eb983a6240e512dc6277b10a9a52a07375528"
    sha256 cellar: :any_skip_relocation, sonoma:        "306eaa55b83c117500ed062f565c834d58e2219ee9d2e2609eed22dd65f514ec"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "af935dedd253bd99cedb68bc8893c1d5e60be9df5f5b694e65555e3b2e6c6844"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b4a417a03f35d25a74fe48c020500462d4f8eccba3ed908e3dcb7604499318da"
  end

  priority "10"

  def install
    Dir.chdir "uopz-#{version}"
    inreplace "src/function.c", "static inline uopz_try_addref(zval *z)",
"static inline void uopz_try_addref(zval *z)"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
