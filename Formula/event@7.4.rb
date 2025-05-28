# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT74 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.4.tgz"
  sha256 "5c4caa73bc2dceee31092ff9192139df28e9a80f1147ade0dfe869db2e4ddfd3"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "fb75390fd39dd94e683cea890e44b1a5ae2216501aa139b5b9a7ae70d2625d4c"
    sha256 cellar: :any,                 arm64_sonoma:   "9c539fc3bf81c9fa5c51afd11710ab7ccba5dd6bd8151a5e9662f6aef8b431c5"
    sha256 cellar: :any,                 arm64_ventura:  "2997c41ad55b6a4f918d78ef892fd7bd77ccc80eacc6667c6b7cf705b09a6426"
    sha256 cellar: :any,                 arm64_monterey: "b99bf487e9e50694006adbb344ee1e52e811a2ec64e38787ac782d44aa594d93"
    sha256 cellar: :any,                 ventura:        "aff5ae670a277cf3f3b27df7537e63e65116a7c4b9ae2a063e869935d2d1b254"
    sha256 cellar: :any,                 monterey:       "e91c69210dbe457410b2195597303ef6bbce44c2c5f84717fe22f57e0bf19339"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "8a3b60d67bb09dc141e0233e53d66884e74782656ed0a792ad4e0c256f304021"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d69f1c3a3b7bb4ca49265dd3fb3be4f0ba9199084efbdd430ed59f1d74683583"
  end

  depends_on "libevent"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --with-event-libevent-dir=#{Formula["libevent"].opt_prefix}
    ]
    Dir.chdir "event-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
