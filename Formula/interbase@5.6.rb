# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT56 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "ade4af7cfe09b1355d466de7e8c3c7daedb96278a592b33724b39d21d577283b"
    sha256 cellar: :any,                 arm64_sequoia: "a8431e99a56b679a942acc64f694723ee00215436f3c0c21c6136c813e10908d"
    sha256 cellar: :any,                 arm64_sonoma:  "5bdbbff41d873b8e86af08ca7c69ba2bab40b4200468311ffa197a35a0df89b4"
    sha256 cellar: :any,                 sonoma:        "220a764a6f94a4e96494badac1cce58e02c1798d62144cfe5cbafa9a21572c7c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ddd1afbd026d7db5118bb3300a641117c65658dab9fac4940318549920110e9d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "493f8083f40faf28d030c2f8bfec05d35ef839c15fdca76ae215bcb621667595"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6cfe49e294414185452ec89bad39b1bd42cc72c9.tar.gz"
  version "5.6.40"
  sha256 "c7aea2d4742a6daadfa333dce1e6707bd648b2ed54e36238674db026e27d43cf"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client@3"].opt_prefix
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
