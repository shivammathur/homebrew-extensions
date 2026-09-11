# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT84 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.14.0.tgz"
  sha256 "c06351f1360bd651057ea73e0186d8fec744292839a4b49c71ce886072c4fff7"
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "f168b6bc9a9183f0da6e6fb113c16c18295c05fca721206447a873b28da4e5fa"
    sha256 cellar: :any, arm64_sequoia: "25ecee1277b15f5e8d6561db1d115e7dcb1eadf0bd2f00d2737cbbc58158e45f"
    sha256 cellar: :any, arm64_sonoma:  "027c6480be7366e22780cf9c607909119af8f6faf98a3a973310a8101e6bb342"
    sha256 cellar: :any, arm64_linux:   "7a3c24fd16a66d1cbdbb8b91ebae70c6ab8df7345e8a23fbe92cefec71307606"
    sha256 cellar: :any, x86_64_linux:  "b31bff109c58507fc13922471d8d73be64f3470d7f3a76b75769167e21e00bdd"
  end

  depends_on "libmaxminddb"

  def install
    Dir.chdir "maxminddb-#{version}/ext"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-maxminddb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
