# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT56 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_golden_gate: "632cc8689209188c18477baf4667244877bacc59b967fc24e94d5d7668a3930e"
    sha256 cellar: :any, arm64_tahoe:       "0a4a79f506a697a37d647f90ed4122223d43e86be4bce6fb52ab329a6fe3f93d"
    sha256 cellar: :any, arm64_sequoia:     "badd595b7e5b31f4794a5488514f18ab90080c744a65c4544cc841be425307db"
    sha256 cellar: :any, arm64_linux:       "9b8ca7f4f74d698d5d3c09bdcf89e3fae1936c2a7470fca948af274ccd976aa3"
    sha256 cellar: :any, x86_64_linux:      "39cc3f0d897b3bf50b83b545428912637c1ecd121676b6fd4452a1ea83933071"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/25fce28ca29c7bea677695e50c5ed52139122d20.tar.gz"
  version "5.6.40"
  sha256 "779061ac26e633a1fd52317531a8473bf89872408540ee708d8e3fa285a89538"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/interbase" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-int-conversion"
      ENV.append "CFLAGS", "-Wno-incompatible-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
