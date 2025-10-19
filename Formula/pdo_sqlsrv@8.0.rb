# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT80 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.12.0.tgz"
  sha256 "22f0cb17b45f0deccd0bba072ee0085ff4094cd6ee2acc26f7f924975ef652c6"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "e25ca3f290b4ab79d2fb7da1ab6268e566fe300a9a207f2bde2916a997d9ae01"
    sha256 cellar: :any,                 arm64_sonoma:   "bda48dbc1c83b62ac0c5b2f003c250a43e718c37ab629aa3094bb31ee479f260"
    sha256 cellar: :any,                 arm64_ventura:  "c059fc6812dbf91f8fdd86ce780460fbb74f18a68f817489e4f2423adb56fac5"
    sha256 cellar: :any,                 arm64_monterey: "7e924b4f423ede9544517c6159fcf38eed3e548f142e9571b7aeb36f1084af78"
    sha256 cellar: :any,                 sonoma:         "ec5159c67c13ce398a5f261b983e4dfea65cd8099f7458aa3996bc0370d56497"
    sha256 cellar: :any,                 ventura:        "a8f3dcf9587f9adb5375e8bf7cd80a18a7c17a1e8e8f5f1e4a37cd5787ef9645"
    sha256 cellar: :any,                 monterey:       "407646b68a12730ff6bdda6f1e9d21fea42e08676efd47942af2388b6b5e64c0"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "25cdad610f631b42ff48eef0fb18608660e9cd0b5a1a011f7ff73efce33bdecc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f3f460ff83607c11bed9eaafba1e78808e7291bf94c806a555dc413a70ab9106"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "pdo_sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-pdo_sqlsrv"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
