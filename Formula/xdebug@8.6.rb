# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/237213d66a21b37c938c7c9a1b50fb7404180051.tar.gz"
  sha256 "1e03f295f9149d551d57313b4091e9ad5d1c0495d278ef7b3e352e81b7ca41d8"
  version "3.5.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256                               arm64_tahoe:   "6a53815fa860ab6aecd6124ceb1e881ce1f88771340737b0357f8f47c873788c"
    sha256                               arm64_sequoia: "e9d3427e978090f1796215183574287f4aa91bc1956eb515fbd505ad482f6417"
    sha256                               arm64_sonoma:  "ef864d3930e9c902a675159d4898005897cff815878bde6c43ec8a5e01da1541"
    sha256 cellar: :any_skip_relocation, sonoma:        "26eda53cabedc2fb9d0b91a8044e84dc476962920e10f3b6d41a7f87ceac389d"
    sha256                               arm64_linux:   "895319c53b76d1061a5658aa6de6cd416bd886e9310a33ea337d27c3fd7aaf5f"
    sha256                               x86_64_linux:  "62c0aec31106e677480671e0a23504da82f5d48dd1bac9a784796d7a0578f906"
  end

  uses_from_macos "zlib"

  patch do
    url "https://github.com/shivammathur/xdebug/commit/13264e7ca3608026f710fb83c5f2314bdcc610e6.patch?full_index=1"
    sha256 "2c0ed06d8adcbdd534132bf4a30a8497a236b576d3dff4c92f1375ec0436f98b"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
