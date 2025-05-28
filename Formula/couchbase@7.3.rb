# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT73 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/php-couchbase"
  url "https://pecl.php.net/get/couchbase-3.2.2.tgz"
  sha256 "d8bd785ccce818e0beb9694cd02ab01ed26e0cf9b19217d2bc2e92b38b21c9c1"
  head "https://github.com/couchbase/php-couchbase.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "2dd3278fd116839af96ef8a9862f9b39b95ff19f636aa1a68c8d6d76be362550"
    sha256 cellar: :any,                 arm64_ventura:  "4e37cb1b05b0e60b82d04cf1023ae712bfea953beaa1fe93a46782ed05005eea"
    sha256 cellar: :any,                 arm64_monterey: "f4334d946fe5d8736c4f1758e960f08f5aa34fd780675e7ef7e5d7e36b8164fb"
    sha256 cellar: :any,                 arm64_big_sur:  "d6dc416b3d0f3ae804df21d85ac426cb2277db6e32c8019d9db8d3ef4a766042"
    sha256 cellar: :any,                 ventura:        "e8984b051c90153e1cd499b171c01284cd35573b13a01b24672aac5955517b9d"
    sha256 cellar: :any,                 monterey:       "3466abd062360a2bd3ca69800aa47a1618ef518df4c846772687506220fd04ad"
    sha256 cellar: :any,                 big_sur:        "24f2f40486fd6d9b7c350bad9f32687cbc039c98a6d5580cac8c4a48d4362d0d"
    sha256 cellar: :any,                 catalina:       "8c1d3b6adee7b56cd90eea0d8a4627175e16dbbc4d695a12773f813ca22e974e"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "465df304371089763b4d338cecf27d21141df5b29ae8fdc0bdab07092788e6db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a2db20fa6d0368f787a61e338b12306144d59a9171287d0bed528dff213e6410"
  end

  depends_on "libcouchbase"
  depends_on "zlib"

  def install
    Dir.chdir "couchbase-#{version}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-couchbase=#{Formula["libcouchbase"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
