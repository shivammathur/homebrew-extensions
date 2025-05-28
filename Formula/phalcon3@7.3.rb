# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Phalcon3AT73 < AbstractPhpExtension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalcon.io/en-us"
  url "https://github.com/phalcon/cphalcon/archive/v3.4.5.tar.gz"
  sha256 "4c56420641a4a12f95e93e65a107aba8ef793817da57a4c29346c012faf66777"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "afec3762fdf6ad6e657e895100f5f2ad90c5337e93d2396a01ef00245014e196"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "0b22ef05017228225c30f0cc2322f6b70b6fe558f5638136a4a095cc968ae933"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "69474b879b0126dc8412d91baec153ff9862c753284a13e009a1a4cb8aaffc9f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e8b71f9583bf4b304ca9068e537541a8bd4444f227360359d6a9dc6bf0a8b315"
    sha256 cellar: :any_skip_relocation, ventura:        "df7f0c863ca6c6473b8b64392aafac19d268e698003c566aa362627a6d9d8e3a"
    sha256 cellar: :any_skip_relocation, big_sur:        "9e65dd0130de5776faaacf4cfb706bd9b3ac99d4ce56ae6536b438d1d7790a89"
    sha256 cellar: :any_skip_relocation, catalina:       "90ffa28c83344eb16333970eb73e574eda758390abe232eda9517b0fef06e547"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "fc73948a4e679547b6f3334817ad5ea1c64c848340c22a1ed469e2e318ab7587"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e21f5aa6adc402f8abee6095231379edccd4c388e6f144ddcc9c474ac181ff6f"
  end

  depends_on "pcre"
  depends_on "shivammathur/extensions/psr@7.3"

  def install
    Dir.chdir "build/php7/64bits"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file
  end
end
