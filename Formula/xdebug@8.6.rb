# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/47fad007984f8de4406ef7f00c6bff2a88cc3605.tar.gz"
  sha256 "66d4ada9809a5168478597ac9f8350ade7ee58ab114de425b97a4d9f8648a84f"
  version "3.5.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256                               arm64_tahoe:   "cd869df330c2e773d191035d95b1947746f8b75e0c85f03498d8ec00ba8747bb"
    sha256                               arm64_sequoia: "f9f23bcf8c38b5fd8ff68bc7ad5b9e87332819210d8183e64cab2c80584235a2"
    sha256                               arm64_sonoma:  "0fab5484f179867c94b8cd3ef9c97ca9704a47849d33d9e7a444e9bdd428aa88"
    sha256 cellar: :any_skip_relocation, sonoma:        "ee1ced57551efe0a792427f1b9dd07814366575c0924ef8e5dbd59f1e1060d8b"
    sha256                               arm64_linux:   "9ecbade90b7e3add21d5c20debd298f1fef24d56aea51ea76c95588cd1687b13"
    sha256                               x86_64_linux:  "0a35214079cb096e7bc7e5f8678fd8a0a2edd0d411ff32d31d2cf2581387d94e"
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
