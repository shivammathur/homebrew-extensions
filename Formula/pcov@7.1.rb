# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT71 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.12.tar.gz"
  sha256 "fdd07cad8e2ff42f0c9f095d84aeef11dab0fde7a008805f61883cbcb1b3f12b"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "dc46932a41aead9fc544e28ae9d48895aa4b48be9805aacf1e6ffbbda2d74251"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c38c7762fba37e3dd63c3bffcbc5bec933b12c87444f1376ec27ed55304fd0fc"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8b3599c52702b9a9e4a06802be76fcea26dd2fe372f837205060cb83406b6e89"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9109cc64a367c4f84c80ecc07c29529e80baf64bccbccc21988a45436d1c9554"
    sha256 cellar: :any_skip_relocation, ventura:        "08e2d2c27cba0f0c2a9b0a68ef79b0e22fd4d01cbb8d77cb3d880e6647c180ff"
    sha256 cellar: :any_skip_relocation, big_sur:        "4d5b61e736703094cf752725173600f518761ee00567a7d3108daf0c6afe0f4c"
    sha256 cellar: :any_skip_relocation, catalina:       "51899184179d8466fcad7cb6a7ca7c04445ad18397a7e9c235572782c39b4dfb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f819e206180c2a685e557e7bb03eacd3cae8470fba4d26db48f3775cd60bacf1"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
