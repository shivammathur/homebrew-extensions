# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT84 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.0.tgz"
  sha256 "0562a41c958a20780b492f91c3815744d976e42e4adac09edb4d2c5add7b0cc7"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c260ea122c77af7d811debc5f0fca6286c645d264978672da2bafd7580e5fe07"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a563500ffc0da86994ac4ffb7b5bd7c7c965efd6a119461a904f0ddae819a755"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e1dd925adeb628dc6a8983767c49d0d8952b9c4935a482ae5c0b9c09decb0e3b"
    sha256 cellar: :any_skip_relocation, sonoma:        "c90c191aa39141c0aa79829110d1d71a2152720d1f6268861f8f640332d184e9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7ee0d2a8a58b6460af150b5da19cd2450d674c4ff4fe0aa83b475d35207ca56e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bd5adf9e570514658393faa32e974700713134e73688e026f19d7402c82c64f4"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
