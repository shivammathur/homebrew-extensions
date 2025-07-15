# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT72 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.19.1.tar.gz"
  sha256 "bfaf2ba7bdb11663bd9364096daa246fa4bfb1dec1eed9fa53ed9a8d5ed1f647"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6d7ec47dec8d38359ca0dd7b0f808f3055c2310eea9738549b4965beaf8f2d4b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a51dfccbfa395d886393025ac95311a2d9878fdb8a347dcf848a4dd594bd1074"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "db138420b0c3027c31f4cd28743a27d065f08f353c00cdc264cb32442f55756c"
    sha256 cellar: :any_skip_relocation, ventura:       "0d8c6dde47939209be1ef4dce4de7dcf60e5a52ef0c4edb002389fc9c26082e6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "55d00d3f0a6cfb552b6f142f1b9fa5fac1856e1c1b3adb622db548e03257af0d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "176c97cc6c45fbb7fc792ccd4666ee0cc1a12e59f3188b745cc2e6bdd5b78e9b"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-vld"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
