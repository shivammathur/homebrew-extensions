# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT81 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.1.tgz"
  sha256 "279749cbe22858af2f69958eeefea3060a2e6545fda1f8fc0fceba0a44f29a20"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5f145450b63e86837d13c46bb8e79649ff7447b6ef41260315c1f1d11ed20596"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9951b29b795309785f350154ddbebd0d8d8b50d571829bf1722d40475015a0f0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ebaf30fc60e5795b1672deb80a95e374f32b07b99a4949e5cb6dd62b697552b7"
    sha256 cellar: :any_skip_relocation, sonoma:        "5d8676c2511c4840bf4390108b271ef7d582034b84a59b16bf320f1cf646ec17"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5c743fcb87e9efe96549024b1238002b55e553a1b1731ef1e5616963da036bc2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4bfca333fb6f172d659c25b6ef159787c6a23ce8382d0be31e46c86f595ec77d"
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
