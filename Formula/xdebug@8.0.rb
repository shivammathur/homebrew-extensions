# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.7.tar.gz"
  sha256 "6959726ee2bb99efd660796736801b198ec0847b6360230a8143ad5e2d2063c2"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "1735cc7038b6f1a1ac3310f43503194b5e3244a41d400c2c1ed4ac50b5b7c6a6"
    sha256                               arm64_sequoia: "7345b640c796c59523eb2fa82d8fbc9bef19a5600c7b2e5cc65277032ce97cae"
    sha256                               arm64_sonoma:  "15920501211a2f3959a7c12583cb80db7267968ac20b52ccce3c13067386f75e"
    sha256 cellar: :any_skip_relocation, sonoma:        "5341dc9301423eedf4a24de380629862a8a4f79459e68ad64a061f2623647383"
    sha256                               arm64_linux:   "7991a794021170dd69fbac1f52068440ccd07930169256e3f269df7ff52c8cc4"
    sha256                               x86_64_linux:  "46ac55c9eeac2e92109b315537b44f8f56db9cfa9bd0b23782fbf82adb2f848e"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
