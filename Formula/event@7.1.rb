# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "3701bc132dca697adfa02df7c3a7506105b146654a69e4e422933253b4111079"
    sha256 cellar: :any,                 arm64_sonoma:   "59ab3fbaf16c6194eeb4a9f07e083bc21a371bf80f8cf6e2e25163326f182f45"
    sha256 cellar: :any,                 arm64_ventura:  "01ad859735dea35dca0a237e843e82862a4e3df5035efccee22a9c8c8404543e"
    sha256 cellar: :any,                 arm64_monterey: "a3da2ae0d2b12478d7b636070fe45545d4692421cadc674b1e7fe89d6851f08f"
    sha256 cellar: :any,                 ventura:        "b56b3cc49885e4ef5e08101e6a0e9e84b7b5d41fd6b38d0c16543d2198819691"
    sha256 cellar: :any,                 monterey:       "ceaeab09b1244439c9507c33078a836158045cbfce397f663a6c1c60b69ccd50"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "50b7d4304946844be0ac4998d2952f9624fc4dfc51196557ff7eda31c877d656"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0dd5488df56d71e19533f6d902358a2c9e2101ac57b40cbdbf73089d8e5a9016"
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
