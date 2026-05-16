# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "063f775f3a1349a1d9d8fbc4b54aa6f588a63739db3b7300c48579752e0ad85e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4fbd47213ceeb456b8369145410bf2efb51226399ff2914edfcd46b853fc4b73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f05302fc7dcde9c286b5d06fbad165977980dd87d64ebb149776697213856594"
    sha256 cellar: :any_skip_relocation, sonoma:        "00e6a194ae4f798f69bcbb6595d7260373b6cd1e663b3425bfb9ab9c233d4e66"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "95d929a4939d20133af0c2af1c1ad465897ef61cfc2f692131999ea49bab31e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "10c0c406a3986b97a189e5506ae3876718cd9096fb7cee77ef7d32998c7fab4a"
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
