# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/c705e8a1c4e7033849a79667d924811b9102ff5f.tar.gz"
  sha256 "b2a897ed5d43c458f6f6ab2169d2289d2d2195ac9f698645b022aeb22d1ee597"
  version "3.5.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256                               arm64_tahoe:   "e6fb322253c83d34bc3d7fd65d93163a9c0f2c268993dd64ca7f94ab3149aa43"
    sha256                               arm64_sequoia: "86fefb47b6236d6d1049e443aa43a8c7a5a4cfbf3f4f539d973fa1dc8d19d67b"
    sha256                               arm64_sonoma:  "d0b1241897f353b63d81cd939f2e4d8f0e555ccbe697bcd28773aa54465b9494"
    sha256 cellar: :any_skip_relocation, sonoma:        "0dc8863b814b5f4909f128d075dbe778070047f9abe701d2686f3caf505cb79b"
    sha256                               arm64_linux:   "68a143253d364fda6777d06f720c47cec2a84b9515ac0dc557026fdc15f22f3f"
    sha256                               x86_64_linux:  "7838554b5991c38245f727bb8f72cbbe2214c24f535715b15d67d63d745a56b4"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

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
