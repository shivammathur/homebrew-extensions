# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT84 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.15.tar.gz"
  sha256 "6fcbd7813eea1dfe00ec72a672cedb1d1cce06b2f23ab3cb148fa5e3edfa3994"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "08c1f462b1497aee63cef8794b686e5996ad876f0d11a5ff20d31be97e903b15"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e87572435a55e035a65aed635f16aa02989bd0e43a95bd5f10362d10ea51976f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7aafddc0738881cd3825caf5e0a4553e895de3b189a2b6916ef64d802de2bce0"
    sha256 cellar: :any_skip_relocation, ventura:        "f596a19da0cffbd938d8adbdcba5faa9b9aef6d77571feb16b918238b3a1222b"
    sha256 cellar: :any_skip_relocation, monterey:       "df75c2bcc448cd08ba83027f75d5ea937e7a7d97d09023008572b25e4eafaa20"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cef80e7261948bf8a7d92632c93fea5e73556839fda8e7dd41e125222f13893c"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
