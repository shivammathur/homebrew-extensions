# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/29e84585e66b01b94f8dc0059dedcc8c55820018.tar.gz"
  version "7.0.33"
  sha256 "87e056213c805ea6c4e6f5527dfa526bbdc74e93d4e64d2d972eb3dd33aa6ba0"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "6a3d07bd76ec0629eec59a6971435d374b78e1f897dd9e000120edd33ca8ebdf"
    sha256 cellar: :any,                 arm64_sequoia: "f1754db4e27fc484994d227bee7809a87080ba39346cdec643e61dfd2a70aebb"
    sha256 cellar: :any,                 arm64_sonoma:  "f475d2ffdc60a735e85047a25854ae369c042c6d3a9f97069d3a50e26e662642"
    sha256 cellar: :any,                 sonoma:        "a690812047cb64aad167cbe53145a8f8fb5853ab01fda7f9029390f122488f07"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fc02cdbed4a74188130ba151f5ea8431cf617bf1320a5513937fd08db0d1c2e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3d7064e0c669114276dc042eba1046fd4618ce221e226207c5b0ac1364c26a7c"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
