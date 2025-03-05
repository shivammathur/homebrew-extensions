# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT83 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.12.tar.gz"
  sha256 "fdd07cad8e2ff42f0c9f095d84aeef11dab0fde7a008805f61883cbcb1b3f12b"
  head "https://github.com/krakjoe/pcov.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c9a686bebcddbe6ccfa64563988c045ac814152f6efc7f21b256a595e91d44de"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d3620489e8e59506d2af663d93211956f87416be9bb0b774583b06e81f0c6a37"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "79e927d6bb4a4e8376b88a4ba82fd16626e470cb1900c6a8b549699b568dfe4c"
    sha256 cellar: :any_skip_relocation, ventura:       "4c8062057c0474259953945445436330672897e40a830778eb0519cae8209c2e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1bc81f618d0ffe4ac69088ced6e6b019d09e904d4e8f75d71c63257efcebc0be"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
