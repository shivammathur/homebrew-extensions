# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT84 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.13.1.tgz"
  sha256 "362839e6a0a50f6253d46ae11b3cae80520582e2b5528423aed9644577a3a93d"
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "fed3c6ff56fc217664b48a3f24d5e942a07b323ccf3a06c3154b07dbfb903360"
    sha256 cellar: :any,                 arm64_sequoia: "5c41b235895fb20204b112b33a5e8ed618bcd2ddb3482c9a70d0f2cf5a52eb1c"
    sha256 cellar: :any,                 arm64_sonoma:  "34ea46a47d942e94f47c8a8bd4e9cc5df2245b0f5fe0f12b5dbf69a9d91b79bb"
    sha256 cellar: :any,                 sonoma:        "ea3b646a713dab951d5221a35a0c5e68bf55da270f19d1577713e9db8fec574a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "09bf9ec4f53bae67dff3fb77ecb36b7202a9a457bd2d54f37ac5d90013b3d69e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58be1a05ae0610b48c70bbca016f8b4825297f542707c0b7f3d76bfa2f4e6faa"
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
